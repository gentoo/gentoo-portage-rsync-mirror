# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-lib/freebsd-lib-7.2-r1.ebuild,v 1.6 2012/08/02 15:25:21 ryao Exp $

EAPI=2

inherit bsdmk freebsd flag-o-matic multilib toolchain-funcs eutils

DESCRIPTION="FreeBSD's base system libraries"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

# Crypto is needed to have an internal OpenSSL header
# sys is needed for libalias, probably we can just extract that instead of
# extracting the whole tarball
SRC_URI="mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${CRYPTO}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2
		mirror://gentoo/${INCLUDE}.tar.bz2
		mirror://gentoo/${USBIN}.tar.bz2
		build? (
			mirror://gentoo/${SYS}.tar.bz2 )"

if [ "${CATEGORY#*cross-}" = "${CATEGORY}" ]; then
	RDEPEND="ssl? ( dev-libs/openssl )
		hesiod? ( net-dns/hesiod )
		kerberos? ( virtual/krb5 )
		userland_GNU? ( sys-apps/mtree )
		!sys-freebsd/freebsd-headers
		dev-libs/libelf"
	DEPEND="${RDEPEND}
		>=sys-devel/flex-2.5.31-r2
		=sys-freebsd/freebsd-sources-${RV}*
		!bootstrap? ( app-arch/bzip2 )"
else
	SRC_URI="${SRC_URI}
			mirror://gentoo/${SYS}.tar.bz2"
fi

DEPEND="${DEPEND}
		=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/lib"

export CTARGET=${CTARGET:-${CHOST}}
if [ "${CTARGET}" = "${CHOST}" -a "${CATEGORY#*cross-}" != "${CATEGORY}" ]; then
	export CTARGET=${CATEGORY/cross-}
fi

IUSE="atm bluetooth ssl hesiod ipv6 kerberos usb netware
	build bootstrap crosscompile_opts_headers-only"

pkg_setup() {
	[ -c /dev/zero ] || \
		die "You forgot to mount /dev; the compiled libc would break."

	if ! use ssl && use kerberos; then
		eerror "If you want kerberos support you need to enable ssl support, too."
	fi

	use atm || mymakeopts="${mymakeopts} WITHOUT_ATM= "
	use bluetooth || mymakeopts="${mymakeopts} WITHOUT_BLUETOOTH= "
	use hesiod || mymakeopts="${mymakeopts} WITHOUT_HESIOD= "
	use ipv6 || mymakeopts="${mymakeopts} WITHOUT_INET6_SUPPORT= "
	use kerberos || mymakeopts="${mymakeopts} WITHOUT_KERBEROS_SUPPORT= "
	use netware || mymakeopts="${mymakeopts} WITHOUT_IPX= WITHOUT_IPX_SUPPORT= WITHOUT_NCP= "
	use ssl || mymakeopts="${mymakeopts} WITHOUT_OPENSSL= "
	use usb || mymakeopts="${mymakeopts} WITHOUT_USB= "

	mymakeopts="${mymakeopts} WITHOUT_BIND= WITHOUT_BIND_LIBS= WITHOUT_SENDMAIL="

	if [ "${CTARGET}" != "${CHOST}" ]; then
		mymakeopts="${mymakeopts} MACHINE=$(tc-arch-kernel ${CTARGET})"
		mymakeopts="${mymakeopts} MACHINE_ARCH=$(tc-arch-kernel ${CTARGET})"
	fi
}

PATCHES=( "${FILESDIR}/${PN}-bsdxml.patch"
	"${FILESDIR}/${PN}-6.0-pmc.patch"
	"${FILESDIR}/${PN}-6.0-gccfloat.patch"
	"${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	"${FILESDIR}/${PN}-6.1-csu.patch"
	"${FILESDIR}/${PN}-6.2-bluetooth.patch"
	"${FILESDIR}/${PN}-new_as.patch"
	"${FILESDIR}/${PN}-7.0-CVE-2008-1391.patch" )

# Here we disable and remove source which we don't need or want
# In order:
# - ncurses stuff
# - archiving libraries (have their own ebuild)
# - sendmail libraries (they are installed by sendmail)
# - SNMP library and dependency (have their own ebuilds)
#
# The rest are libraries we already have somewhere else because
# they are contribution.
# Note: libtelnet is an internal lib used by telnet and telnetd programs
# as it's not used in freebsd-lib package itself, it's pointless building
# it here.
REMOVE_SUBDIRS="ncurses
	libz libbz2 libarchive \
	libsm libsmdb libsmutil \
	libbegemot libbsnmp \
	libpam libpcap bind libwrap libmagic \
	libcom_err libtelnet
	libedit libelf"

src_prepare() {
	sed -i.bak -e 's:-o/dev/stdout:-t:' "${S}/libc/net/Makefile.inc"
	sed -i.bak -e 's:histedit.h::' "${WORKDIR}/include/Makefile"

	# Upstream Display Managers default to using VT7
	# We should make FreeBSD allow this by default
	local x=
	for x in "${WORKDIR}"/etc/etc.*/ttys ; do
		sed -i.bak \
			-e '/ttyv5[[:space:]]/ a\
# Display Managers default to VT7.\
# If you use the xdm init script, keep ttyv6 commented out\
# unless you force a different VT for the DM being used.' \
			-e '/^ttyv[678][[:space:]]/ s/^/# /' "${x}" \
			|| die "Failed to sed ${x}"
		rm "${x}".bak
	done

	# This one is here because it also
	# patches "${WORKDIR}/include"
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}-includes.patch"
	epatch "${FILESDIR}/${P}-rtldnoload.patch"

	# Don't install the hesiod man page or header
	rm "${WORKDIR}"/include/hesiod.h || die
	sed -i.bak -e 's:hesiod.h::' "${WORKDIR}"/include/Makefile || die
	sed -i.bak -e 's:hesiod.c::' -e 's:hesiod.3::' \
	"${WORKDIR}"/lib/libc/net/Makefile.inc || die

	# Apply this patch for Gentoo/FreeBSD/SPARC64 to build correctly
	# from catalyst, then don't do anything else
	if use build; then
		cd "${WORKDIR}"
		# This patch has to be applied on ${WORKDIR}/sys, so we do it here since it
		# shouldn't be a symlink to /usr/src/sys (which should be already patched)
		epatch "${FILESDIR}"/${PN}-7.1-types.h-fix.patch
		# Preinstall includes so we don't use the system's ones.
		mkdir "${WORKDIR}/include_proper" || die "Couldn't create ${WORKDIR}/include_proper"
		install_includes "/include_proper"
		return 0
	fi

	if [ "${CTARGET}" = "${CHOST}" ]; then
		ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys" || die "Couldn't make sys symlink!"
	else
		sed -i.bak -e "s:/usr/include:/usr/${CTARGET}/usr/include:g" \
			"${S}/libc/rpc/Makefile.inc" \
			"${S}/libc/yp/Makefile.inc"
	fi

	if install --version 2> /dev/null | grep -q GNU; then
		sed -i.bak -e 's:${INSTALL} -C:${INSTALL}:' "${WORKDIR}/include/Makefile"
	fi

	# Preinstall includes so we don't use the system's ones.
	mkdir "${WORKDIR}/include_proper" || die "Couldn't create ${WORKDIR}/include_proper"
	install_includes "/include_proper"

	# Let arch-specific includes to be found
	local machine
	machine=$(tc-arch-kernel ${CTARGET})
	ln -s "${WORKDIR}/sys/${machine}/include" "${WORKDIR}/include/machine" || \
		die "Couldn't make ${machine}/include symlink."

	cd "${S}"
	use bootstrap && dummy_mk libstand
}

src_compile() {
	cd "${WORKDIR}/include"
	$(freebsd_get_bmake) CC=$(tc-getCC) || die "make include failed"

	use crosscompile_opts_headers-only && return 0

	# Don't use ssp until properly fixed
	append-flags $(test-flags -fno-stack-protector -fno-stack-protector-all)

	# Bug #270098
	append-flags $(test-flags -fno-strict-aliasing)

	strip-flags
	if [ "${CTARGET}" != "${CHOST}" ]; then
		export YACC='yacc -by'
		CHOST=${CTARGET} tc-export CC LD CXX

		local machine
		machine=$(tc-arch-kernel ${CTARGET})

		local csudir
		if [ -d "${S}/csu/${machine}-elf" ]; then
			csudir="${S}/csu/${machine}-elf"
		else
			csudir="${S}/csu/${machine}"
		fi
		cd "${csudir}"
		$(freebsd_get_bmake) ${mymakeopts} || die "make csu failed"

		append-flags "-isystem /usr/${CTARGET}/usr/include"
		append-flags "-isystem ${WORKDIR}/lib/libutil"
		append-flags "-isystem ${WORKDIR}/lib/msun/${machine/i386/i387}"
		append-flags "-B ${csudir}"
		append-ldflags "-B ${csudir}"

		cd "${S}/libc"
		$(freebsd_get_bmake) ${mymakeopts} || die "make libc failed"
		cd "${S}/msun"
		$(freebsd_get_bmake) ${mymakeopts} || die "make libc failed"
	else
		# Forces to use the local copy of headers as they might be outdated in
		# the system
		append-flags "-isystem '${WORKDIR}/include_proper'"

		cd "${S}"
		NOFLAGSTRIP=yes freebsd_src_compile
	fi
}

src_install() {
	[ "${CTARGET}" = "${CHOST}" ] \
		&& INCLUDEDIR="/usr/include" \
		|| INCLUDEDIR="/usr/${CTARGET}/usr/include"
	dodir ${INCLUDEDIR}
	einfo "Installing for ${CTARGET} in ${CHOST}.."
	install_includes ${INCLUDEDIR}

	# Install math.h when crosscompiling, at this point
	if [ "${CHOST}" != "${CTARGET}" ]; then
		insinto "/usr/${CTARGET}/usr/include"
		doins "${S}/msun/src/math.h"
	fi

	use crosscompile_opts_headers-only && return 0

	if [ "${CTARGET}" != "${CHOST}" ]; then
		local csudir
		if [ -d "${S}/csu/$(tc-arch-kernel ${CTARGET})-elf" ]; then
			csudir="${S}/csu/$(tc-arch-kernel ${CTARGET})-elf"
		else
			csudir="${S}/csu/$(tc-arch-kernel ${CTARGET})"
		fi
		cd "${csudir}"
		$(freebsd_get_bmake) ${mymakeopts} DESTDIR="${D}" install \
			FILESDIR="/usr/${CTARGET}/usr/lib" LIBDIR="/usr/${CTARGET}/usr/lib" || die "Install csu failed"

		cd "${S}/libc"
		$(freebsd_get_bmake) ${mymakeopts} DESTDIR="${D}" install NO_MAN= \
			SHLIBDIR="/usr/${CTARGET}/lib" LIBDIR="/usr/${CTARGET}/usr/lib" || die "Install failed"

		cd "${S}/msun"
		$(freebsd_get_bmake) ${mymakeopts} DESTDIR="${D}" install NO_MAN= \
			INCLUDEDIR="/usr/${CTARGET}/usr/include" \
			SHLIBDIR="/usr/${CTARGET}/lib" LIBDIR="/usr/${CTARGET}/usr/lib" || die "Install failed"

		dosym "usr/include" "/usr/${CTARGET}/sys-include"
	else
		cd "${S}"
		# Set SHLIBDIR and LIBDIR for multilib
		SHLIBDIR="/$(get_libdir)" LIBDIR="/usr/$(get_libdir)" mkinstall || die "Install failed"
	fi

	# Don't install the rest of the configuration files if crosscompiling
	if [ "${CTARGET}" != "${CHOST}" ] ; then
		# This is to get it stripped with the correct tools, otherwise it gets
		# stripped with the host strip.
		export CHOST=${CTARGET}
		return 0
	fi

	# Add symlinks (-> libthr) for legacy threading libraries, since these are
	# not built by us (they are disabled in FreeBSD-7 anyway).
	dosym libthr.a /usr/$(get_libdir)/libpthread.a
	dosym libthr.so /usr/$(get_libdir)/libpthread.so
	dosym libthr.a /usr/$(get_libdir)/libc_r.a
	dosym libthr.so /usr/$(get_libdir)/libc_r.so

	# Add symlink (-> libthr) so previously built binaries still work.
	dosym libthr.so.3 /$(get_libdir)/libpthread.so.2
	dosym libthr.so.3 /$(get_libdir)/libc_r.so.6

	# Compatibility symlinks to run FreeBSD 5.x binaries (ABI is mostly
	# identical, remove when problems will actually happen)
	dosym /lib/libc.so.7 /usr/$(get_libdir)/libc.so.6
	dosym /lib/libc.so.6 /usr/$(get_libdir)/libc.so.5
	dosym /lib/libm.so.4 /usr/$(get_libdir)/libm.so.3
	dosym /lib/libm.so.5 /usr/$(get_libdir)/libm.so.4

	# install libstand files
	dodir /usr/include/libstand
	insinto /usr/include/libstand
	doins "${S}"/libstand/*.h

	cd "${WORKDIR}/etc/"
	insinto /etc
	doins auth.conf nls.alias mac.conf netconfig

	# Install ttys file
	if [[ $(tc-arch-kernel) == "x86_64" ]]; then
		local MACHINE="amd64"
	else
		local MACHINE="$(tc-arch-kernel)"
	fi
	doins "etc.${MACHINE}"/*

	# Generate ldscripts, otherwise bad thigs are supposed to happen
	gen_usr_ldscript libalias_cuseeme.so libalias_dummy.so libalias_ftp.so \
		libalias_irc.so libalias_nbt.so libalias_pptp.so libalias_skinny.so \
		libalias_smedia.so
	# These show on QA warnings too, however they're pretty much bsd only,
	# aka, no autotools for them.
	#	libbsdxml.so libcam.so libcrypt.so libdevstat.so libgeom.so \
	#	libipsec.so libipx.so libkiconv.so libkvm.so libmd.so libsbuf.so libufs.so \
	#	libutil.so

	dodir /etc/sandbox.d
	cat - > "${D}"/etc/sandbox.d/00freebsd <<EOF
# /dev/crypto is used mostly by OpenSSL on *BSD platforms
# leave it available as packages might use OpenSSL commands
# during compile or install phase.
SANDBOX_PREDICT="/dev/crypto"
EOF
}

install_includes()
{
	local INCLUDEDIR="$1"

	# The idea is to be called from either install or unpack.
	# During unpack it's required to install them as portage's user.
	if [[ "${EBUILD_PHASE}" == "install" ]]; then
		local DESTDIR="${D}"
		BINOWN="root"
		BINGRP="wheel"
	else
		local DESTDIR="${WORKDIR}"
		[[ -z "${USER}" ]] && USER="portage"
		BINOWN="${USER}"
		[[ -z "${GROUPS}" ]] && GROUPS="portage"
		BINGRP="${GROUPS}"
	fi

	# Must exist before we use it.
	[[ -d "${DESTDIR}${INCLUDEDIR}" ]] || die "dodir or mkdir ${INCLUDEDIR} before using install_includes."
	cd "${WORKDIR}/include"

	if [[ $(tc-arch-kernel) == "x86_64" ]]; then
		local MACHINE="amd64"
	else
		local MACHINE="$(tc-arch-kernel)"
	fi

	einfo "Installing includes into ${INCLUDEDIR} as ${BINOWN}:${BINGRP}..."
	$(freebsd_get_bmake) installincludes \
		MACHINE=${MACHINE} DESTDIR="${DESTDIR}" \
		INCLUDEDIR="${INCLUDEDIR}" BINOWN="${BINOWN}" \
		BINGRP="${BINGRP}" || die "install_includes() failed"
	einfo "includes installed ok."
}
