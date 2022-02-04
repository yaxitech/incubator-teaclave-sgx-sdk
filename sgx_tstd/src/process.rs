use crate::os::unix::io::{IntoRawFd, RawFd};

pub struct ChildStdin;
pub struct ChildStdout;
pub struct ChildStderr;

impl IntoRawFd for ChildStdin {
    fn into_raw_fd(self) -> RawFd {
        unimplemented!()
    }
}

impl IntoRawFd for ChildStdout {
    fn into_raw_fd(self) -> RawFd {
        unimplemented!()
    }
}

impl IntoRawFd for ChildStderr {
    fn into_raw_fd(self) -> RawFd {
        unimplemented!()
    }
}

#[cold]
pub fn abort() -> ! {
    crate::sys::abort_internal();
}
