# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mcl/mcl-08.312.ebuild,v 1.2 2012/04/26 16:17:02 jlec Exp $

EAPI=4

MY_P="${PN}-${PV/./-}"

DESCRIPTION="A Markov Cluster Algorithm implementation"
HOMEPAGE="http://micans.org/mcl/"
SRC_URI="http://micans.org/mcl/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+blast"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_enable blast)
}
