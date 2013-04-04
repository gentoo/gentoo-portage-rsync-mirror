# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.59-r7.ebuild,v 1.17 2013/04/04 18:44:03 vapier Exp $

inherit eutils

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="${PV:0:3}"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="emacs"

DEPEND="=sys-devel/m4-1.4*
	dev-lang/perl"
RDEPEND="${DEPEND}
	sys-devel/autoconf-wrapper"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-more-quotes.patch
}

src_compile() {
	(use emacs && type -p emacs) \
		&& export EMACS=emacs \
		|| export EMACS=no
	econf --program-suffix="-${PV}" || die
	# econf updates config.{sub,guess} which forces the manpages
	# to be regenerated which we dont want to do #146621
	touch man/*.1
	# We want to transform the binaries, not the manpages
	sed -i "/^program_transform_name/s:-${PV}::" man/Makefile
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS NEWS README TODO THANKS \
		ChangeLog ChangeLog.0 ChangeLog.1 ChangeLog.2
}

pkg_postinst() {
	einfo "Please note that the 'WANT_AUTOCONF_2_5=1' syntax is now:"
	einfo "  WANT_AUTOCONF=2.5"
}
