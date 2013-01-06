# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc/uclibc-0.9.28.3-r8.ebuild,v 1.8 2012/06/09 06:47:12 vapier Exp $

#ESVN_REPO_URI="svn://uclibc.org/trunk/uClibc"
#inherit subversion
inherit eutils flag-o-matic toolchain-funcs

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi
# Handle the case where we want uclibc on glibc ...
if [[ ${CTARGET} == ${CHOST} ]] && [[ ${CHOST} != *-uclibc ]] ; then
	export UCLIBC_AND_GLIBC="sitting in a tree"
	export CTARGET=${CHOST%%-*}-pc-linux-uclibc
fi

MY_P=uClibc-${PV}
SVN_VER=""
PATCH_VER="1.9"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="mirror://kernel/linux/libs/uclibc/${MY_P}.tar.bz2
	http://uclibc.org/downloads/${MY_P}.tar.bz2
	nls? ( !userlocales? ( pregen? (
		x86? ( http://www.uclibc.org/downloads/uClibc-locale-030818.tgz )
	) ) )"
[[ -z ${SVN_VER} ]] || \
	SRC_URI="${SRC_URI} mirror://gentoo/${MY_P}-svn-update-${SVN_VER}.patch.bz2"
[[ -z ${PATCH_VER} ]] || \
	SRC_URI="${SRC_URI} mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="-* arm m68k -mips ppc sh ~sparc x86"
IUSE="build uclibc-compat debug hardened iconv ipv6 minimal nls pregen savedconfig userlocales wordexp crosscompile_opts_headers-only"
RESTRICT="strip"

RDEPEND=""
if [[ ${CTARGET} == ${CHOST} ]] ; then
	DEPEND="virtual/os-headers app-misc/pax-utils"
else
	DEPEND=""
fi

S=${WORKDIR}/${MY_P}

alt_build_kprefix() {
	if [[ ${CBUILD} == ${CHOST} && ${CTARGET} == ${CHOST} ]] \
	   || [[ -n ${UCLIBC_AND_GLIBC} ]]
	then
		echo /usr
	else
		echo /usr/${CTARGET}/usr
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

	if ! built_with_use --missing false ${CATEGORY}/uclibc nls && use nls && ! use pregen ; then
		eerror "You previously built uclibc with USE=-nls."
		eerror "You cannot generate locale data with this"
		eerror "system.  Please rerun emerge with USE=pregen."
		die "host cannot support locales"
	elif built_with_use --missing false ${CATEGORY}/uclibc nls && ! use nls ; then
		eerror "You previously built uclibc with USE=nls."
		eerror "Rebuilding uClibc with USE=-nls will prob"
		eerror "destroy your system."
		die "switching from nls is baaaad"
	fi
}

PIE_STABLE="arm mips ppc x86"

CPU_ALPHA=""
CPU_AMD64=""
CPU_ARM="GENERIC_ARM ARM{610,710,720T,920T,922T,926T,_{SA110,SA1100,XSCALE}}"
CPU_IA64=""
CPU_M68K=""
CPU_MIPS="MIPS_ISA_{1,2,3,4,MIPS{32,64}}"
CPU_PPC=""
CPU_SH="SH{2,3,4,5}"
CPU_SPARC=""
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
		# math functions (sinf,cosf,tanf,atan2f,powf,fabsf,copysignf,scalbnf,rem_pio2f)
		cp "${WORKDIR}"/patch/math/libm/* "${S}"/libm/ || die
		epatch "${WORKDIR}"/patch/math
	fi

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
	sed -i -e "s:default TARGET_i386:default TARGET_${target}:" \
		extra/Configs/Config.in
	sed -i -e "s:default CONFIG_${config_target}:default CONFIG_${UCLIBC_CPU:-${config_target}}:" \
		extra/Configs/Config.${target}

	########## CONFIG SETUP ##########

	make defconfig >/dev/null || die "could not config"

	for def in DO{DEBUG{,_PT},ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} ; do
		sed -i -e "s:${def}=y:# ${def} is not set:" .config
	done
	if use debug ; then
		#echo "SUPPORT_LD_DEBUG_EARLY=y" >> .config
		echo "SUPPORT_LD_DEBUG=y" >> .config
		echo "DODEBUG=y" >> .config
		#echo "DODEBUG_PT=y" >> .config
	fi

	sed -i -e '/ARCH_.*_ENDIAN/d' .config
	echo "ARCH_$(uclibc_endian | tr [a-z] [A-Z])_ENDIAN=y" >> .config

	local moredefs="DL_FINI_CRT_COMPAT"
	# We need todo this for a few months. .28 is a major upgrade.
	# Don't do it from cross-compiling case though
	if ! use uclibc-compat ; then
		if [[ -z ${UCLIBC_AND_GLIBC} ]] && [[ -z ${UCLIBC_SCANNED_COMPAT} ]] && \
		   ! just_headers && [[ ${CHOST} == ${CTARGET} ]] ; then
			local fnames=""
			einfo "Doing a scanelf in paths for bins containing the __uClibc_start_main symbol"
			fnames=$(scanelf -pyqs__uClibc_start_main -F%F#s)
			if [[ -z ${fnames} ]] ; then
				einfo "This system is clean."
				einfo "To prevent the scanning of files again in the future you can export UCLIBC_SCANNED_COMPAT=1"
				moredefs=""
			else
				ewarn "You need to remerge the packages that contain the following files before you can remerge ${P} without USE=uclibc-compat enabled."
				ewarn "qfile ${fnames}"
				echo
				ewarn "Leaving on ${moredefs}"
			fi
		else
			moredefs=""
		fi
	fi
	for def in ${moredefs} MALLOC_GLIBC_COMPAT DO_C99_MATH UCLIBC_HAS_{RPC,CTYPE_CHECKED,WCHAR,HEXADECIMAL_FLOATS,GLIBC_CUSTOM_PRINTF,FOPEN_EXCLUSIVE_MODE,GLIBC_CUSTOM_STREAMS,PRINTF_M_SPEC,FTW} ; do
		sed -i -e "s:# ${def} is not set:${def}=y:" .config
	done
	echo "UCLIBC_HAS_FULL_RPC=y" >> .config
	echo "PTHREADS_DEBUG_SUPPORT=y" >> .config
	echo "UCLIBC_HAS_TZ_FILE_READ_MANY=n" >> .config

	if use iconv ; then
		sed -i -e "s:# UCLIBC_HAS_LOCALE is not set:UCLIBC_HAS_LOCALE=y:" .config
		echo "UCLIBC_HAS_XLOCALE=n" >> .config
		echo "UCLIBC_HAS_GLIBC_DIGIT_GROUPING=y" >> .config
		echo "UCLIBC_HAS_SCANF_LENIENT_DIGIT_GROUPING=y" >> .config

		if use nls ; then
			echo "UCLIBC_HAS_GETTEXT_AWARENESS=y" >> .config
		else
			echo "UCLIBC_HAS_GETTEXT_AWARENESS=n" >> .config
		fi

		if use pregen ; then
			echo "UCLIBC_PREGENERATED_LOCALE_DATA=y" >> .config
			echo "UCLIBC_DOWNLOAD_PREGENERATED_LOCALE_DATA=y" >> .config
			if use userlocales ; then
				cp "${DISTDIR}"/${MY_P}-user-locale.tar.gz \
					extra/locale/uClibc-locale-030818.tgz \
					|| die "could not copy ${MY_P}-user-locale.tar.gz"
			else
				cp "${DISTDIR}"/${MY_P}-$(tc-arch)-full-locale.tar.gz \
					extra/locale/uClibc-locale-030818.tgz \
					|| die "could not copy locale"
			fi
		else
			echo "UCLIBC_PREGENERATED_LOCALE_DATA=n" >> .config
		fi
	else
		echo "UCLIBC_HAS_LOCALE=n" >> .config
	fi

	use ipv6 && sed -i -e "s:# UCLIBC_HAS_IPV6 is not set:UCLIBC_HAS_IPV6=y:" .config

	# uncomment if you miss wordexp (alsa-lib)
	use wordexp && sed -i -e "s:# UCLIBC_HAS_WORDEXP is not set:UCLIBC_HAS_WORDEXP=y:" .config

	# we need to do it independently of hardened to get ssp.c built into libc
	sed -i -e "s:# UCLIBC_SECURITY.*:UCLIBC_SECURITY=y:" .config
	echo "UCLIBC_HAS_SSP=y" >> .config
	echo "SSP_USE_ERANDOM=n" >> .config
	echo "PROPOLICE_BLOCK_ABRT=n" >> .config
	if use debug ; then
		echo "PROPOLICE_BLOCK_SEGV=y" >> .config
		echo "PROPOLICE_BLOCK_KILL=n" >> .config
	else
		echo "PROPOLICE_BLOCK_SEGV=n" >> .config
		echo "PROPOLICE_BLOCK_KILL=y" >> .config
	fi

	# arm/mips do not emit PT_GNU_STACK, but if we enable this here
	# it will be emitted as RWE, ppc has to be checked, x86 needs it
	# this option should be used independently of hardened
	# relro could be also moved out of hardened
	if has $(tc-arch) x86 ; then
		echo "UCLIBC_BUILD_NOEXECSTACK=y" >> .config
	else
		echo "UCLIBC_BUILD_NOEXECSTACK=n" >> .config
	fi
	echo "UCLIBC_BUILD_RELRO=y" >> .config
	if use hardened ; then
		if has $(tc-arch) ${PIE_STABLE} ; then
			echo "UCLIBC_BUILD_PIE=y" >> .config
		else
			echo "UCLIBC_BUILD_PIE=n" >> .config
		fi
		echo "SSP_QUICK_CANARY=n" >> .config
		echo "UCLIBC_BUILD_SSP=y" >> .config
		echo "UCLIBC_BUILD_NOW=y" >> .config
	else
		echo "UCLIBC_BUILD_PIE=n" >> .config
		echo "SSP_QUICK_CANARY=y" >> .config
		echo "UCLIBC_BUILD_SSP=n" >> .config
		echo "UCLIBC_BUILD_NOW=n" >> .config
	fi

	# Allow users some custom control over the config
	if use savedconfig ; then
		for conf in ${PN}-${PV}-${PR} ${PN}-${PV} ${PN}; do
			configfile=${ROOT}/etc/${PN}/${CTARGET}/${conf}.config
			einfo "Checking existence of ${configfile} ..."
			[[ -r ${configfile} ]] || configfile=/etc/${PN}/${CHOST}/${conf}.config
			if [[ -r ${configfile} ]] ; then
				cp "${configfile}" "${S}"/.config
				einfo "Found your ${configfile} and using it."
				einfo "Note that this feature is *totally unsupported*."
				break
			fi
		done
	fi

	# setup build and run paths
	local cross=${CTARGET}-
	type -p ${cross}ar > /dev/null || cross=""
	sed -i \
		-e "/^CROSS_COMPILER_PREFIX/s:=.*:=\"${cross}\":" \
		-e "/^KERNEL_SOURCE/s:=.*:=\"$(alt_build_kprefix)\":" \
		-e "/^SHARED_LIB_LOADER_PREFIX/s:=.*:=\"/$(get_libdir)\":" \
		-e "/^DEVEL_PREFIX/s:=.*:=\"/usr\":" \
		-e "/^RUNTIME_PREFIX/s:=.*:=\"/\":" \
		.config || die

	yes "" 2> /dev/null | make -s oldconfig > /dev/null || die "could not make oldconfig"

	cp .config myconfig

	emake -s clean > /dev/null || die "could not clean"
}

setup_locales() {
	cd "${S}"/extra/locale
	if use userlocales && [[ -f ${ROOT}/etc/locales.build ]] ; then
		:;
	elif use minimal ; then
		find ./charmaps -name ASCII.pairs > codesets.txt
		find ./charmaps -name ISO-8859-1.pairs >> codesets.txt
		cat <<-EOF > locales.txt
		@euro e
		UTF-8 yes
		8-bit yes
		en_US ISO-8859-1
		en_US.UTF-8 UTF-8
		EOF
	else
		find ./charmaps -name '*.pairs' > codesets.txt
		cp LOCALES locales.txt
	fi
	cd -
}

src_compile() {
	cp myconfig .config

	emake headers || die "make headers failed"
	just_headers && return 0

	if use iconv && ! use pregen ; then
		cd extra/locale
		make clean || die "make locale clean failed"
		setup_locales
		emake || die "make locales failed"
		cd ../..
	fi

	emake || die "make failed"
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		emake -C utils hostutils || die "make hostutils failed"
	elif [[ ${CHOST} == *-uclibc ]] ; then
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
	just_headers && target="install_dev"
	emake DESTDIR="${sysroot}" ${target} || die "install failed"

	# remove files coming from kernel-headers
	rm -rf "${sysroot}"/usr/include/{linux,asm*}

	if [[ -e ${D}/usr/include/bits/fenv.h && ! -e ${D}/usr/include/fenv.h ]] ; then
		# install fenv.h for newer gcc versions #266298
		cat <<-EOF > "${D}"/usr/include/fenv.h
		#ifndef _FENV_H
		#define _FENV_H
		#include <features.h>
		#include <bits/fenv.h>
		#endif
		EOF
	fi

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

	if [[ ${ROOT} == "/" ]] ; then
		# update cache before reloading init
		/sbin/ldconfig
		# reload init ...
		[[ -x /sbin/telinit ]] && /sbin/telinit U &> /dev/null
	fi
}
