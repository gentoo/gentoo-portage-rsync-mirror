# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/itstool/itstool-1.2.0.ebuild,v 1.20 2013/03/29 13:23:41 ago Exp $

EAPI="4"
PYTHON_USE_WITH="xml"
PYTHON_DEPEND="2:2.5"

inherit python

DESCRIPTION="Translation tool for XML documents that uses gettext files and ITS rules"
HOMEPAGE="http://itstool.org/"
SRC_URI="http://files.itstool.org/itstool/${P}.tar.bz2"

# files in /usr/share/itstool/its are HPND/as-is || GPL-3
LICENSE="GPL-3+ || ( HPND GPL-3+ )"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 ~sh ~sparc x86 ~amd64-fbsd ~arm-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/libxml2[python]"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS=(ChangeLog NEWS) # AUTHORS, README are empty
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}
