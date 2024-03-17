Stop-and-Wait Protocol in Short:

- Sender sends one frame at a time.
- After sending a frame, it waits for an acknowledgment (ACK).
- If no ACK is received within a timeout, sender resends the frame.
- Receiver sends ACK for error-free frames.
- Receiver discards damaged or out-of-sequence frames.
- Provides implicit flow control; sender waits for ACK before sending next frame.
- Simple to implement but has low efficiency and high latency.
- Suitable for scenarios prioritizing reliability over speed, such as point-to-point communication over noisy channels.
