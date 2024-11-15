# DreamCoder: Fork of the Original Repository

This is a modified version of [DreamCoder](https://github.com/ellisk42/ec), originally developed by Kevin Ellis and collaborators. The original repository implements a wake-sleep algorithm to find programs that solve tasks in a particular domain.

---

## **Important: Singularity Installation**

Ensure that Singularity is installed and configured properly for compatibility with the Go library. Follow the steps in the [Singularity Installation Guide](https://docs.sylabs.io/guides/3.0/user-guide/installation.html) for setup.

---

## Modifications in this Fork

- **Updated Singularity Files**:
  - Adjusted version dependencies for compatibility:
    - `yojson` updated to `1.6.0`
    - `menhir` updated to `20211128`

- **Added `incr.py`**:
  - A new file, `incr.py`, is added to check the working of creating new domains in DreamCoder.

- Other files are unchanged from the original repository.

---

## Original Credits

The original codebase, including this README, was cloned from [DreamCoder on GitHub](https://github.com/ellisk42/ec).
