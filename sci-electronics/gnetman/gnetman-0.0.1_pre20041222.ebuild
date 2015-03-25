# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnetman/gnetman-0.0.1_pre20041222.ebuild,v 1.5 2015/03/25 16:54:29 jlec Exp $

EAPI=4

MY_PV="22Dec04"

DESCRIPTION="A GNU Netlist Manipulation Library"
HOMEPAGE="http://www.viasic.com/opensource/"
SRC_URI="http://www.viasic.com/opensource/gnetman-${MY_PV}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc ~x86"

DEPEND="dev-lang/tk:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"
