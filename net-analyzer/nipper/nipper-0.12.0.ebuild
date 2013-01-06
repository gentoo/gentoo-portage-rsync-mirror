# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nipper/nipper-0.12.0.ebuild,v 1.1 2008/08/30 19:08:47 ikelos Exp $

inherit cmake-utils

DESCRIPTION="Router configuration security analysis tool"
HOMEPAGE="http://nipper.titania.co.uk/"
SRC_URI="mirror://sourceforge/nipper/${PN}-cli-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=net-libs/libnipper-0.12"
RDEPEND=""

S=${WORKDIR}/${PN}-cli-${PV}
