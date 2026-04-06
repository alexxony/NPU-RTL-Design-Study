# 🚀 NPU RTL Design: From Compiler to Hardware
모델 경량화(Quantization) 및 컴파일러 스케줄링 지식을 RTL(Register Transfer Level)로 구현하여, 저전력·고효율 AI 가속기 아키텍처를 설계하는 프로젝트입니다.

---

## 🏗️ Project Architecture & Strategy
소프트웨어 계층(Python/PyTorch)의 연산 로직이 실제 실리콘 레벨에서 어떻게 물리적으로 구현되는지 탐구합니다.
- **Goal:** Quantization-Aware Hardware 설계 및 Dataflow 최적화
- **Environment:** Verilog HDL, Icarus Verilog, GTKWave, GitHub Codespaces

---

## 🟢 Step 1: Combinational Logic & Data Routing
NPU 내에서 데이터의 흐름을 제어하고 연산 자원을 할당하기 위한 기초 조합 회로를 설계했습니다.

### 1. 주요 모듈
- **Mux 2-to-1:** 컴파일러의 데이터 경로 제어 로직을 하드웨어로 구현.
- **Priority Encoder (4-to-2):** 여러 연산 유닛의 요청을 하드웨어 레벨에서 우선순위에 따라 즉시 중재.

### 2. 시뮬레이션 결과
![Step 1 Waveform](./images/step1_waveform.png)
- 입력 신호 변화에 따른 출력의 즉각적인 전이(Transition)를 확인하여 조합 회로의 특성을 검증했습니다.

---

## 🔵 Step 2: Sequential Logic & Timing Synchronization
조합 회로에 '시간(Clock)' 개념을 도입하여 데이터를 저장하고 흐름을 제어하는 순차 회로를 설계했습니다.

### 1. 주요 모듈
- **D-FlipFlop (D-FF):** 클럭의 상승 에지(Rising Edge)에서 데이터를 샘플링하여 유지하는 최소 기억 소자.
- **Insight:** 컴파일러가 계산하는 **'1-Cycle Latency'**가 물리적으로 발생하는 지점을 이해하고 동기화 로직을 구축했습니다.

### 2. 시뮬레이션 결과
![Step 2 Waveform](./images/step2_waveform.png)
- 입력 `d`가 변하더라도 `q`는 반드시 `clk` 박자에 맞춰 업데이트되는 동기식 동작을 확인했습니다.

---

## 🛠️ Upcoming Milestones
- [ ] **Step 3:** 8-bit Register & Counter (데이터 묶음 처리)
- [ ] **Step 4:** Simple FSM (명령어 제어 로직 기초)
