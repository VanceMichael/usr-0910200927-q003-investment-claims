# 投洽成果声明对账服务

项目归并活动各参与方提交的合作成果声明，并保留关联与披露依据。来源、签署阶段和金额差异口径位于 `contracts/claim_rules.json`，本地状态写入 H2 文件库。

```bash
docker build -t investment-claim-reconciler .
docker run --rm -p 8080:8080 investment-claim-reconciler
curl http://localhost:8080/health
```

披露组的关联与锁定操作由领域层负责，HTTP 错误统一返回结构化问题信息。
