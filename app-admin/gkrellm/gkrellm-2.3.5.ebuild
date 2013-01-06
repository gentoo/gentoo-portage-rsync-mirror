# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.3.5.ebuild,v 1.11 2012/05/31 02:30:55 zmedico Exp $

EAPI=2

inherit eutils multilib toolchain-funcs user

DESCRIPTION="Single process stack of various system monitors"
HOMEPAGE="http://www.gkrellm.net/"
SRC_URI="http://members.dslextreme.com/users/billw/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="hddtemp gnutls lm_sensors nls ssl ntlm X kernel_FreeBSD"

RDEPEND="dev-libs/glib:2
	hddtemp? ( app-admin/hddtemp )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl ) )
	lm_sensors? ( sys-apps/lm_sensors )
	nls? ( virtual/libintl )
	ntlm? ( net-libs/libntlm )
	X? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	enewgroup gkrellmd
	enewuser gkrellmd -1 -1 -1 gkrellmd
	TARGET=
	use kernel_FreeBSD && TARGET="freebsd"
}

src_prepare() {
	sed -e 's:-O2 ::' \
		-e 's:override CC:CFLAGS:' \
		-i */Makefile || die "sed Makefile(s) failed"

	sed -e 's:#user\tnobody:user\tgkrellmd:' \
		-e 's:#group\tproc:group\tgkrellmd:' \
		-i server/gkrellmd.conf || die "sed gkrellmd.conf failed"

	sed -e "s:/usr/lib:/usr/$(get_libdir):" \
		-e "s:/usr/local/lib:/usr/local/$(get_libdir):" \
		-i src/${PN}.h || die "sed ${PN}.h failed"
}

src_compile() {
	if use X ; then
		local sslopt=""
		if use gnutls; then
			sslopt="without-ssl=yes"
		elif use ssl; then
			sslopt="without-gnutls=yes"
		else
			sslopt="without-ssl=yes without-gnutls=yes"
		fi

		emake ${TARGET} \
			CC="$(tc-getCC)" \
			STRIP="" \
			INSTALLROOT="/usr" \
			INCLUDEDIR="/usr/include/gkrellm2" \
			LOCALEDIR="/usr/share/locale" \
			$(use nls || echo enable_nls=0) \
			$(use lm_sensors || echo without-libsensors=yes) \
			$(use ntlm || echo without-ntlm=yes) \
			${sslopt} \
		|| die "emake failed"
	else
		cd server
		emake ${TARGET} \
			CC="$(tc-getCC)" \
			LINK_FLAGS="$LDFLAGS -Wl,-E" \
			STRIP="" \
			$(use nls || echo enable_nls=0) \
			$(use lm_sensors || echo without-libsensors=yes) \
		|| die "emake failed"
	fi
}

src_install() {
	if use X ; then
		emake install${TARGET:+_}${TARGET} \
			$(use nls || echo enable_nls=0) \
			STRIP="" \
			INSTALLDIR="${D}/usr/bin" \
			INCLUDEDIR="${D}/usr/include" \
			LOCALEDIR="${D}/usr/share/locale" \
			PKGCONFIGDIR="${D}/usr/$(get_libdir)/pkgconfig" \
			MANDIR="${D}/usr/share/man/man1" \
		|| die "emake install failed"

		dohtml *.html

		newicon src/icon.xpm ${PN}.xpm
		make_desktop_entry ${PN} GKrellM ${PN}
	else
		dobin server/gkrellmd || die "dobin failed"

		insinto /usr/include/gkrellm2
		doins server/gkrellmd.h || die "doins failed"
		doins shared/log.h || die "doins failed"
	fi

	doinitd "${FILESDIR}"/gkrellmd || die "doinitd failed"
	newconfd "${FILESDIR}"/gkrellmd.conf gkrellmd || die "newconfd failed"

	insinto /etc
	doins server/gkrellmd.conf || die "doins failed"

	dodoc Changelog CREDITS README
}

pkg_postinst() {
	if use X ; then
		ewarn "The old executable name 'gkrellm2' has been removed."
		ewarn "Run 'gkrellm' instead."
	fi
}
