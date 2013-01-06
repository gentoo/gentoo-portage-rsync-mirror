# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linux-logo/linux-logo-5.11-r1.ebuild,v 1.6 2012/09/13 03:47:59 ottxor Exp $

EAPI="4"

inherit toolchain-funcs

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A utility that displays an ANSI/ASCII logo and some system information"
HOMEPAGE="http://www.deater.net/weave/vmwprod/linux_logo/"
SRC_URI="http://www.deater.net/weave/vmwprod/linux_logo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	cp "${FILESDIR}"/logo_config "${S}/" || die
	cp "${FILESDIR}"/gentoo{,2}.logo "${S}"/logos/ \
		|| die "Unable to copy Gentoo logos"
	echo "NAME gentoo" >> "${S}"/logos/gentoo.logo
	# Remove warn_unused_result warning
	sed -i -e 's/FILE \*fff;/FILE \*fff;\n   char *stemp;/' \
	    -e 's/fgets/stemp=fgets/' "${S}"/load_logo.c || die "sed failed"
}

src_configure() {
	ARCH="" ./configure --prefix="${ED}"/usr || die "configure failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)"
}

src_install() {
	emake install

	dodoc BUGS README README.CUSTOM_LOGOS TODO USAGE LINUX_LOGO.FAQ

	newinitd "${FILESDIR}"/${PN}.init.d ${PN}
	newconfd "${FILESDIR}"/${P}.conf ${PN}
}

pkg_postinst() {
	echo
	elog "Linux_logo ebuild for Gentoo comes with two Gentoo logos."
	elog ""
	elog "To display the first Gentoo logo type: linux_logo -L gentoo"
	elog "To display the second Gentoo logo type: linux_logo -L gentoo-alt"
	elog "To display all the logos available type: linux_logo -L list."
	elog ""
	elog "To start linux_logo on boot, please type:"
	elog "   rc-update add linux-logo default"
	elog "which uses the settings found in"
	elog "   /etc/conf.d/linux-logo"
	echo
}

pkg_prerm() {
	# Restore issue files
	mv /etc/issue.linux-logo.backup /etc/issue 2> /dev/null
	mv /etc/issue.net.linux-logo.backup /etc/issue.net 2> /dev/null
}
