# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmldiff/xmldiff-0.6.9.ebuild,v 1.11 2012/08/27 15:18:13 floppym Exp $

EAPI="3"

inherit distutils

DESCRIPTION="A tool that figures out the differences between two similar XML files"
HOMEPAGE="http://www.logilab.org/project/xmldiff"
SRC_URI="ftp://ftp.logilab.fr/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-python/pyxml"
RDEPEND="${DEPEND}"

DOCS="ChangeLog README README.xmlrev TODO"
