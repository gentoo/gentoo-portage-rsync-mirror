# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/autodia/autodia-2.100.0-r1.ebuild,v 1.1 2011/03/27 18:14:29 tove Exp $

EAPI=3

MY_PN=Autodia
MODULE_AUTHOR=TEEJAY
MODULE_VERSION=2.10
inherit perl-app multilib

DESCRIPTION="A application that parses source code, XML or data and produces an XML document in Dia format"
HOMEPAGE="http://www.aarontrevena.co.uk/opensource/autodia/ ${HOMEPAGE}"
SRC_URI+=" http://dev.gentoo.org/~tove/files/Autodia-cpan50879.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz"

RDEPEND="
	dev-perl/Template-Toolkit
	dev-perl/XML-Simple
	graphviz? ( dev-perl/GraphViz )"

DEPEND="${RDEPEND}"

SRC_TEST=do

PATCHES=( "${WORKDIR}"/Autodia-cpan50879.patch )

src_install() {
	mydoc="FAQ DEVELOP TODO"
	perl-module_src_install
	dosym ${VENDOR_LIB}/autodia.pl /usr/bin/autodia.pl || die
}
