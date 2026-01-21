#在上一个绘制基因表达矩阵热图后，得到"heatmap_gene_clusters.csv"

#将探针标号转变为基因名称，并按照原来顺序输出

options(stringsAsFactors = F)
a=read.csv("heatmap_gene_clusters.csv")
#library(stringr)
#str_split(a$X,'[_]')


# 1. 安装并加载注释包（如果是第一次使用需要运行 BiocManager::install）
BiocManager::install("hgu133plus2.db")
library(hgu133plus2.db)

# 2. 提取探针 ID 与 Gene Symbol 的对应关系
#含义：从注释包中提取一个“对照表”。
ids <- toTable(hgu133plus2SYMBOL)

# 3. 将你的聚类结果与注释表合并
# 假设你的数据框叫 a，且探针 ID 在行名或 X 列
colnames(ids) <- c("X", "symbol") # 统一列名方便合并


colnames(a)
colnames(ids)


final_genes <- merge(a, ids, by = "X")


b=final_genes


table(table(final_genes$symbol)>1)

table(final_genes$symbol)[table(final_genes$symbol)>1]

#按字母顺序排列
final_genes=final_genes[order(final_genes$symbol),]

final_genes=final_genes[!duplicated(final_genes$symbol),]

table(table(final_genes$symbol)>1)

nrow(final_genes)

final_genes=final_genes[match(b$X, final_genes$X),]

# 仅保留 symbol 列中不是 NA 的行
final_genes <- final_genes[!is.na(final_genes$symbol), ]

# 检查删除后的总行数
nrow(final_genes)



# 4. 查看转换后的结果
head(final_genes)
