/*
BSD 2-Clause License

Copyright (c) 2019, Adib Mohsin
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

library neurone;

import 'dart:async';

class _Event {
  final event;
  final data;
  _Event(this.event, this.data);
}

/// The main neurone constructor built on top of streams
/// Create each instance of it for single bus events
/// supports flutter
class Neurone {
  List dataCache = [];
  StreamController<_Event> _streamController;
  Neurone({
    bool synchronize = false,
  }) {
    _streamController = StreamController<_Event>.broadcast(sync: synchronize);
  }

  /// Emit an event
  /// [String event] is the main identifier , the listenr uniquely listens for this
  /// [dynamic data] can pass any form of data
  void emit(String event, [dynamic data = null]) {
    if (data == null) {
      _streamController.add(_Event(event, null));
    } else {
      dataCache.add({"$event": data});
      _streamController.add(_Event(event, data));
    }
  }

  /// Listen for data
  /// [String event] is the unique event identifier
  /// [Function callback] is called after listening and sorting the unique event .
  /// [Function callback] passes data as a parameter , it's null if data is not set when the neurone was emitted
  void listen<_Event>(String event, Function callback) {
    _streamController.stream.listen((_) {
      dataCache.forEach((i) {
        if (i[event] != null) {
          callback(i[event]);
        } else {
          return;
        }
      });
    });
  }

  /// kill the neurone
  void kill() {
    _streamController.close();
  }

  /// Create your own custom [Neurone] with a custom [StreamController]
  Neurone.custom(StreamController<_Event> customNeurone) {
    _streamController = customNeurone;
  }
}
