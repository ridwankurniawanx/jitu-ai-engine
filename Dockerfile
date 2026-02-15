FROM vllm/vllm-openai:latest

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV MODEL_NAME="deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct"
ENV QUANTIZATION="fp8"
ENV MAX_MODEL_LEN="32768"

EXPOSE 8000

CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", \
     "--model", "deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct", \
     "--quantization", "fp8", \
     "--max-model-len", "32768"]
