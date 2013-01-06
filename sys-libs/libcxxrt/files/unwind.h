/* 
 * Copyright 2012 David Chisnall. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */ 

#include_next <unwind.h>

#ifndef CXXRT_UNWIND_H_INCLUDED
#define CXXRT_UNWIND_H_INCLUDED

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __arm__
#define DECLARE_PERSONALITY_FUNCTION(name) \
_Unwind_Reason_Code name(_Unwind_State state,\
                         struct _Unwind_Exception *exceptionObject,\
                         struct _Unwind_Context *context);

#define BEGIN_PERSONALITY_FUNCTION(name) \
_Unwind_Reason_Code name(_Unwind_State state,\
                         struct _Unwind_Exception *exceptionObject,\
                         struct _Unwind_Context *context)\
{\
	int version = 1;\
	uint64_t exceptionClass = exceptionObject->exception_class;\
	int actions;\
	switch (state)\
	{\
		default: return _URC_FAILURE;\
		case _US_VIRTUAL_UNWIND_FRAME:\
		{\
			actions = _UA_SEARCH_PHASE;\
			break;\
		}\
		case _US_UNWIND_FRAME_STARTING:\
		{\
			actions = _UA_CLEANUP_PHASE;\
			if (exceptionObject->barrier_cache.sp == _Unwind_GetGR(context, 13))\
			{\
				actions |= _UA_HANDLER_FRAME;\
			}\
			break;\
		}\
		case _US_UNWIND_FRAME_RESUME:\
		{\
			return continueUnwinding(exceptionObject, context);\
			break;\
		}\
	}\
	_Unwind_SetGR (context, 12, (unsigned long)exceptionObject);\

#define CALL_PERSONALITY_FUNCTION(name) name(state,exceptionObject,context)
#else
#define DECLARE_PERSONALITY_FUNCTION(name) \
_Unwind_Reason_Code name(int version,\
                         _Unwind_Action actions,\
                         uint64_t exceptionClass,\
                         struct _Unwind_Exception *exceptionObject,\
                         struct _Unwind_Context *context);
#define BEGIN_PERSONALITY_FUNCTION(name) \
_Unwind_Reason_Code name(int version,\
                         _Unwind_Action actions,\
                         uint64_t exceptionClass,\
                         struct _Unwind_Exception *exceptionObject,\
                         struct _Unwind_Context *context)\
{

#define CALL_PERSONALITY_FUNCTION(name) name(version, actions, exceptionClass, exceptionObject, context)
#endif

#ifdef __cplusplus
}
#endif

#endif
