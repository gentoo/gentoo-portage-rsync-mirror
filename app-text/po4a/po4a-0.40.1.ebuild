# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.40.1.ebuild,v 1.1 2010/10/19 16:18:04 tove Exp $

EAPI=2

inherit perl-app

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://po4a.alioth.debian.org"
SRC_URI="mirror://debian/pool/main/p/po4a/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	app-text/openjade
	dev-perl/Locale-gettext
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.34.0201
	test? ( app-text/docbook-sgml-dtd
		app-text/docbook-sgml-utils
		virtual/tex-base )"

SRC_TEST="do"
S=${WORKDIR}/${PN}-v${PV}

src_prepare() {
	cp "${FILESDIR}"/compare-po.pl "${S}"/t/ || die
	rm "${S}"/Makefile || die
	sed -i '/^Makefile$/d' "${S}"/MANIFEST || die
	perl-module_src_prepare
}
