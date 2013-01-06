# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc/uclibc-0.9.30.1.ebuild,v 1.10 2012/06/09 06:47:12 vapier Exp $

#ESVN_REPO_URI="svn://uclibc.org/trunk/uClibc"
#inherit subversion
inherit eutils flag-o-matic toolchain-funcs savedconfig

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi
# Handle the case where we want uclibc on glibc ...
if [[ ${CTARGET} == ${CHOST} ]] && [[ ${CHOST} != *-uclibc* ]] ; then
	export UCLIBC_AND_GLIBC="sitting in a tree"
	export CTARGET=${CHOST%%-*}-pc-linux-uclibc
fi

MY_P=uClibc-0.9.30.1
SVN_VER=""
#PATCH_VER="1.0"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://uclibc.org/downloads/${MY_P}.tar.bz2"

[[ -z ${SVN_VER} ]] || \
	SRC_URI="${SRC_URI} mirror://gentoo/${MY_P}-svn-update-${SVN_VER}.patch.bz2"
[[ -z ${PATCH_VER} ]] || \
	SRC_URI="${SRC_URI} mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~m68k ~mips ~ppc ~sh ~sparc ~x86"
IUSE="build uclibc-compat debug hardened ssp ipv6 minimal wordexp crosscompile_opts_headers-only"
RESTRICT="strip"

RDEPEND=""
if [[ -n $CTARGET && ${CTARGET} != ${CHOST} ]]; then
	DEPEND=""
	SLOT="${CTARGET}"
else
	DEPEND="virtual/os-headers app-misc/pax-utils"
	SLOT="0"
fi

S=${WORKDIR}/${MY_P}

alt_build_kprefix() {
	if [[ ${CBUILD} == ${CHOST} && ${CTARGET} == ${CHOST} ]] \
	   || [[ -n ${UCLIBC_AND_GLIBC} ]]
	then
		echo /usr/include
	else
		echo /usr/${CTARGET}/usr/include
	fi
}

just_headers() {
	use crosscompile_opts_headers-only && [[ ${CHOST} != ${CTARGET} ]]
}

uclibc_endian() {
	# XXX: this wont work for a toolchain which is bi-endian, but we
	#      dont have any such thing at the moment, so not a big deal
	touch "${T}"/endian.s
	$(tc-getAS ${CTARGET}) "${T}"/endian.s -o "${T}"/endian.o
	case $(file "${T}"/endian.o) in
		*" MSB "*) echo "big";;
		*" LSB "*) echo "little";;
		*)         echo "NFC";;
	esac
	rm -f "${T}"/endian.{s,o}
}

pkg_setup() {
	just_headers && return 0
	has_version ${CATEGORY}/uclibc || return 0
	[[ -n ${UCLIBC_AND_GLIBC} ]] && return 0
	[[ ${ROOT} != "/" ]] && return 0
	[[ ${CATEGORY} == cross-* ]] && return 0

}

PIE_STABLE="arm mips ppc x86"

CPU_ALPHA=""
CPU_AMD64=""
CPU_ARM="GENERIC_ARM ARM{610,710,7TDMI,720T,920T,922T,926T,10T,1136JF_S,1176JZ{_,F_}S,_{SA110,SA1100,XSCALE,IWMMXT}}"
CPU_IA64=""
CPU_M68K=""
CPU_MIPS="MIPS_ISA_{1,2,3,4,MIPS{32,64}} MIPS_{N64,O32,N32}_ABI"
CPU_PPC=""
CPU_SH="SH{2,3,4,5}"
CPU_SPARC="SPARC_V{7,8,9,9B}"
CPU_X86="GENERIC_386 {3,4,5,6}86 586MMX PENTIUM{II,III,4} K{6,7} ELAN CRUSOE WINCHIP{C6,2} CYRIXIII NEHEMIAH"
IUSE_UCLIBC_CPU="${CPU_ARM} ${CPU_MIPS} ${CPU_PPC} ${CPU_SH} ${CPU_SPARC} ${CPU_X86}"

check_cpu_opts() {
	local cpu_var="CPU_$(echo $(tc-arch) | tr [a-z] [A-Z])"
	[[ -z ${!cpu_var} ]] && return 0

	if [[ -z ${UCLIBC_CPU} ]] ; then
		ewarn "You really should consider setting UCLIBC_CPU"
		ewarn "Otherwise, the build will be generic (read: slow)."
		ewarn "Available CPU options:"
		UCLIBC_CPU=$(eval echo ${!cpu_var})
		echo ${UCLIBC_CPU}
		case ${CTARGET} in
			mips[1234]*) export UCLIBC_CPU="MIPS_ISA_${CTARGET:4:1}";;
			sh[2345]*)   export UCLIBC_CPU="SH${CTARGET:2:1}";;
			i[456]86*)   export UCLIBC_CPU="${CTARGET:1:1}86";;
			*)           export UCLIBC_CPU=${UCLIBC_CPU%% *};;
		esac
	else
		local cpu found=0
		for cpu in $(eval echo ${!cpu_var}) ; do
			[[ ${UCLIBC_CPU} == "${cpu}" ]] && found=1 && break
		done
		if [[ ${found} -eq 0 ]] ; then
			ewarn "UCLIBC_CPU choice '${UCLIBC_CPU}' not supported"
			ewarn "Valid choices:"
			eval echo ${!cpu_var}
			die "pick a supported cpu type"
		fi
	fi
}

set_opt() {
	sed -i -e "/^\# $1 is not set/d" -e "/^$1=.*/d" .config
	echo "$1=$2" >> .config
}

src_unpack() {
	[[ -n ${ESVN_REPO_URI} ]] \
		&& subversion_src_unpack \
		|| unpack ${A}
	cd "${S}"

	check_cpu_opts

	echo
	einfo "Runtime Prefix: /"
	einfo "Devel Prefix:   /usr"
	einfo "Kernel Prefix:  $(alt_build_kprefix)"
	einfo "CBUILD:         ${CBUILD}"
	einfo "CHOST:          ${CHOST}"
	einfo "CTARGET:        ${CTARGET}"
	einfo "CPU:            ${UCLIBC_CPU:-default}"
	einfo "ENDIAN:         $(uclibc_endian)"
	echo

	########## PATCHES ##########

	[[ -n ${SVN_VER} ]] && \
		epatch "${WORKDIR}"/${MY_P}-cvs-update-${SVN_VER}.patch

	if [[ -n ${PATCH_VER} ]] ; then
		unpack ${MY_P}-patches-${PATCH_VER}.tar.bz2
		EPATCH_SUFFIX="patch"
		epatch "${WORKDIR}"/patch
	fi

	sed -i 's:getline:get_line:' extra/scripts/unifdef.c #277186

	########## CPU SELECTION ##########

	local target config_target
	case $(tc-arch) in
		alpha) target="alpha";   config_target="no cpu-specific options";;
		amd64) target="x86_64";  config_target="no cpu-specific options";;
		arm)   target="arm";     config_target="GENERIC_ARM";;
		ia64)  target="ia64";    config_target="no cpu-specific options";;
		m68k)  target="m68k";    config_target="no cpu-specific options";;
		mips)  target="mips";    config_target="MIPS_ISA_1";;
		ppc)   target="powerpc"; config_target="no cpu-specific options";;
		sh)    target="sh";      config_target="SH4";;
		sparc) target="sparc";   config_target="no cpu-specific options";;
		x86)   target="i386";    config_target="GENERIC_386";;
		*)     die "$(tc-arch) lists no defaults :/";;
	esac
	sed -i -e "s:default CONFIG_${config_target}:default CONFIG_${UCLIBC_CPU:-${config_target}}:" \
		extra/Configs/Config.${target}
	sed -i -e "s:^HOSTCC.*=.*:HOSTCC=$(tc-getBUILD_CC):" Rules.mak

	########## CONFIG SETUP ##########

	make ARCH=${target} defconfig >/dev/null || die "could not config"

	for def in DO{DEBUG{,_PT},ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} UCLIBC_HAS_PROFILING; do
		sed -i -e "s:${def}=y:# ${def} is not set:" .config
	done
	if use debug ; then
		set_opt SUPPORT_LD_DEBUG y
		set_opt DODEBUG y
	fi

	sed -i -e '/ARCH_.*_ENDIAN/d' .config
	set_opt "ARCH_WANTS_$(uclibc_endian | tr [a-z] [A-Z])_ENDIAN" y

	if [[ ${CTARGET/eabi} != ${CTARGET} ]] ; then
		set_opt CONFIG_ARM_OABI n
		set_opt CONFIG_ARM_EABI y
	fi

	local moredefs="COMPAT_ATEXIT"
	local compat_sym=atexit

	# We need todo this for a few months. .30 is a major upgrade.
	# Don't do it from cross-compiling case though
	if ! use uclibc-compat ; then
		if [[ -z ${UCLIBC_AND_GLIBC} ]] && [[ -z ${UCLIBC_SCANNED_COMPAT} ]] && \
		   ! just_headers && [[ ${CHOST} == ${CTARGET} ]] ; then
			local fnames=""
			einfo "Doing a scanelf in paths for bins containing the ${compat_sym} symbol"
			fnames=$(scanelf -pyqs${compat_sym} -F%F#s)
			if [[ -z ${fnames} ]] ; then
				einfo "This system is clean."
				einfo "To prevent the scanning of files again in the future you can export UCLIBC_SCANNED_COMPAT=1"
				moredefs=""
			else
				ewarn "You need to remerge the packages that contain the following files before you can remerge ${P} without USE=uclibc-compat enabled."
				ewarn "qfile -Cq $(echo ${fnames}) | sort | uniq"
				echo
				ewarn "Leaving on ${moredefs}"
			fi
		else
			moredefs=""
		fi
	fi
	for def in ${moredefs} MALLOC_GLIBC_COMPAT DO_C99_MATH UCLIBC_HAS_{RPC,FULL_RPC,CTYPE_CHECKED,WCHAR,HEXADECIMAL_FLOATS,GLIBC_CUSTOM_PRINTF,FOPEN_EXCLUSIVE_MODE,GLIBC_CUSTOM_STREAMS,PRINTF_M_SPEC,FTW} UCLIBC_HAS_REENTRANT_RPC  UCLIBC_HAS_GNU_GLOB PTHREADS_DEBUG_SUPPORT UCLIBC_HAS_TZ_FILE_READ_MANY UCLIBC_HAS_FENV UCLIBC_SUSV3_LEGACY UCLIBC_SUSV3_LEGACY_MACROS UCLIBC_HAS_PROGRAM_INVOCATION_NAME ; do
		set_opt "${def}" y
	done
	set_opt UCLIBC_HAS_CTYPE_UNSAFE n
	set_opt UCLIBC_HAS_LOCALE n

	use ipv6 && set_opt UCLIBC_HAS_IPV6 y

	use wordexp && set_opt UCLIBC_HAS_WORDEXP y

	# we need to do it independently of hardened to get ssp.c built into libc
	set_opt UCLIBC_HAS_SSP y
	set_opt UCLIBC_HAS_SSP_COMPAT y
	set_opt UCLIBC_HAS_ARC4RANDOM y
	set_opt PROPOLICE_BLOCK_ABRT n
	set_opt PROPOLICE_BLOCK_SEGV y

	# arm/mips do not emit PT_GNU_STACK, but if we enable this here
	# it will be emitted as RWE, ppc has to be checked, x86 needs it
	# this option should be used independently of hardened
	if has $(tc-arch) x86 || has $(tc-arch) ppc; then
		set_opt UCLIBC_BUILD_NOEXECSTACK y
	else
		set_opt UCLIBC_BUILD_NOEXECSTACK n
	fi
	set_opt UCLIBC_BUILD_RELRO y
	if use hardened ; then
		if has $(tc-arch) ${PIE_STABLE} ; then
			set_opt UCLIBC_BUILD_PIE y
		else
			set_opt UCLIBC_BUILD_PIE n
		fi
		set_opt UCLIBC_BUILD_NOW y
		use ssp && {
			set_opt SSP_QUICK_CANARY n
			set_opt UCLIBC_BUILD_SSP y
		}
	else
		set_opt UCLIBC_BUILD_PIE n
		set_opt SSP_QUICK_CANARY y
		set_opt UCLIBC_BUILD_SSP n
		set_opt UCLIBC_BUILD_NOW n
	fi

	restore_config .config

	# setup build and run paths
	local cross=${CTARGET}-
	type -p ${cross}ar > /dev/null || cross=""
	sed -i \
		-e "/^CROSS_COMPILER_PREFIX/s:=.*:=\"${cross}\":" \
		-e "/^KERNEL_HEADERS/s:=.*:=\"$(alt_build_kprefix)\":" \
		-e "/^SHARED_LIB_LOADER_PREFIX/s:=.*:=\"/$(get_libdir)\":" \
		-e "/^DEVEL_PREFIX/s:=.*:=\"/usr\":" \
		-e "/^RUNTIME_PREFIX/s:=.*:=\"/\":" \
		-e "/^UCLIBC_EXTRA_CFLAGS/s:=.*:=\"${UCLIBC_EXTRA_CFLAGS}\":" \
		.config || die

	yes "" 2> /dev/null | make -s oldconfig > /dev/null || die "could not make oldconfig"

	cp .config myconfig

	emake -s clean > /dev/null || die "could not clean"
}

src_compile() {
	cp myconfig .config

	emake headers || die "make headers failed"
	just_headers && return 0

	emake || die "make failed"
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		emake -C utils hostutils || die "make hostutils failed"
	elif [[ ${CHOST} == *-uclibc* ]] ; then
		emake utils || die "make utils failed"
	fi
}

src_test() {
	[[ ${CHOST} != ${CTARGET} ]] && return 0
	[[ ${CBUILD} != ${CHOST} ]] && return 0

	# assert test fails on pax/grsec enabled kernels - normal
	# vfork test fails in sandbox (both glibc/uclibc)
	make UCLIBC_ONLY=1 check || die "test failed"
}

src_install() {
	local sysroot=${D}
	[[ ${CHOST} != ${CTARGET} ]] && sysroot="${sysroot}/usr/${CTARGET}"

	local target="install"
	just_headers && target="install_headers"
	emake DESTDIR="${sysroot}" ${target} || die "install failed"

	save_config .config

	# remove files coming from kernel-headers
	rm -rf "${sysroot}"/usr/include/{linux,asm*}

	# Make sure we install the sys-include symlink so that when
	# we build a 2nd stage cross-compiler, gcc finds the target
	# system headers correctly.  See gcc/doc/gccinstall.info
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		dosym usr/include /usr/${CTARGET}/sys-include
		if ! just_headers ; then
			newbin utils/ldconfig.host ${CTARGET}-ldconfig || die
			newbin utils/ldd.host ${CTARGET}-ldd || die
		fi
		return 0
	fi

	if [[ ${CHOST} == *-uclibc* ]] ; then
		emake DESTDIR="${D}" install_utils || die "install-utils failed"
		dobin extra/scripts/getent
	fi

	dodoc Changelog* README TODO docs/*.txt DEDICATION.mjn3
}

pkg_postinst() {
	[[ ${CTARGET} != ${CHOST} ]] && return 0
	[[ ${CHOST} != *-uclibc* ]] && return 0

	if [[ ! -e ${ROOT}/etc/TZ ]] ; then
		ewarn "Please remember to set your timezone in /etc/TZ"
		[[ ! -d ${ROOT}/etc ]] && mkdir -p "${ROOT}"/etc
		echo "UTC" > "${ROOT}"/etc/TZ
	fi
	[[ ${ROOT} != "/" ]] && return 0
	# update cache before reloading init
	/sbin/ldconfig
	# reload init ...
	[[ -x /sbin/telinit ]] && /sbin/telinit U &> /dev/null
}
