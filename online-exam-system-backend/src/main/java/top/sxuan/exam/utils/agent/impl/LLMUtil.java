package top.sxuan.exam.utils.agent.impl;

import top.sxuan.exam.utils.agent.AIChat;
import top.sxuan.exam.utils.agent.Assistant;
import top.sxuan.exam.utils.agent.Constants;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.SystemMessage;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.model.openai.OpenAiChatModel;
import dev.langchain4j.service.AiServices;
// import org.jcp.xml.dsig.internal.dom.Utils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

/**
 * 大语言模型实现AIChat
 * 目前只可以直接与大模型进行对话，
 * 目前java版本是8不能使用embedding模型和向量数据库，
 * 如果确实使用这个功能，需要升级java17
 *
 */
@Service
@ConditionalOnProperty(name = "online-exam.chat-platform.type", havingValue = "llm")
public class LLMUtil implements AIChat {

    @Value("${llm.api-key}")
    private String llmApiKey;

    @Value("${llm.base-url}")
    private String llmBaseUrl;

    @Value("${llm.model}")
    private String llmModelName;

    @Value("${embedding.api-key}")
    private String embeddingApiKey;

    @Value("${embedding.base-url}")
    private String embeddingBaseUrl;

    @Value("${embedding.model}")
    private String embeddingModelName;

    @Override
    // 获取聊天响应的方法
    public String getChatResponse(String msg) {
        // 创建一个助手（Assistant）
        Assistant assistant = createAssistant();

        // 直接调用 assistant，AiServices 会自动处理 SystemMessage 注入（如果在 Assistant 接口上定义了）
        // 或者手动以对话形式传递：
        return assistant.answer(msg);
    }

    // 创建助手（Assistant）的方法
    private Assistant createAssistant() {

        // 初始化 OpenAI 的聊天语言模型（LLM），并配置相关参数
        OpenAiChatModel llm = OpenAiChatModel.builder().apiKey(llmApiKey) // 设置 OpenAI API 密钥
                .modelName(llmModelName) // 设置使用的模型名称
                .baseUrl(llmBaseUrl) // 设置 OpenAI API 的基础 URL
                .temperature(Constants.temperature) // 设置生成文本的随机性
                .maxTokens(Constants.maxToken) // 设置生成文本的最大 token 数
                .build();

        // 初始化嵌入模型（确保维度与模型匹配）
        /*
         * EmbeddingModel embeddingModel = OpenAiEmbeddingModel.builder()
         * .baseUrl(embeddingBaseUrl)
         * .apiKey(embeddingApiKey)
         * .modelName(embeddingModelName) // 明确指定模型名称
         * .build();
         * 
         * // 嵌入式存储配置（Java 8 兼容版本）
         * // Milvus 相关配置已被移除以确保 Java 8 兼容性
         * 
         * // 初始化内容检索器（Content Retriever），用于根据用户的查询检索相关的文本片段
         * ContentRetriever contentRetriever =
         * EmbeddingStoreContentRetriever.builder().embeddingStore(embeddingStore) //
         * 使用嵌入存储
         * .embeddingModel(embeddingModel) // 使用嵌入模型计算相似度
         * .maxResults(Constants.maxResults) // 设置检索的最大结果数量
         * .minScore(Constants.minScore) // 设置检索的最低相似度分数
         * .build();
         * 
         * // 初始化聊天记忆（Chat Memory），用于保存最近的对话历史
         * ChatMemory chatMemory =
         * MessageWindowChatMemory.withMaxMessages(Constants.withMaxMessages);
         */

        // 使用 AiServices 构建助手实例，并设置相关组件
        return AiServices.builder(Assistant.class).chatLanguageModel(llm) // 设置聊天语言模型
                // .contentRetriever(contentRetriever) // 设置内容检索器
                // .chatMemory(chatMemory) // 设置聊天记忆
                .build();
    }

    // // 将相对路径转换为绝对路径
    // public Path toPath(String relativePath) {
    // try {
    // // 使用类加载器获取资源路径，并将其转换为 URI 形式的 Path
    // URL fileUrl = Utils.class.getClassLoader().getResource(relativePath);
    // return Paths.get(fileUrl.toURI());
    // } catch (URISyntaxException e) {
    // // 如果发生 URI 格式异常，则抛出运行时异常
    // throw new RuntimeException(e);
    // }
    // }

    // 先运行这个代码构建向量数据库
    /*
     * public void creatKnowledgeBase() {
     * // 将文档路径转换为 Path 对象
     * // Path directoryPath = toPath(Constants.knowledgeBasePath);
     * 
     * // 递归加载指定路径下的所有文档，并使用 Apache Tika 解析器解析内容
     * // List<Document> documents =
     * FileSystemDocumentLoader.loadDocumentsRecursively(directoryPath);
     * 
     * // 使用递归分割器将文档分割成较小的段落
     * // DocumentSplitter splitter =
     * DocumentSplitters.recursive(Constants.maxSegmentSizeInChars, // 每个片段的最大字符数
     * // Constants.maxOverlapSizeChars // 相邻片段之间的最大重叠字符数
     * // );
     * 
     * // 存储分割后的文本片段
     * // List<TextSegment> segments = new ArrayList<>();
     * // documents.forEach(document -> segments.addAll(splitter.split(document)));
     * 
     * 
     * // 初始化嵌入模型（确保维度与模型匹配）
     * // EmbeddingModel embeddingModel = OpenAiEmbeddingModel.builder()
     * // .baseUrl(embeddingBaseUrl)
     * // .apiKey(embeddingApiKey)
     * // .modelName(embeddingModelName) // 明确指定模型名称
     * // .build();
     * 
     * // 生成嵌入向量
     * // List<Embedding> embeddings = embeddingModel.embedAll(segments).content();
     * 
     * // 配置嵌入存储（Java 8 兼容版本）
     * // Milvus 相关配置已被移除以确保 Java 8 兼容性
     * 
     * // 在 Java 8 兼容版本中，这里可以使用内存存储或其他兼容的嵌入存储方案
     * // store.addAll(embeddings, segments);
     * }
     */
}