# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/re2c/re2c-0.13.5-r1.ebuild,v 1.8 2013/03/03 08:54:25 vapier Exp $

EAPI=4

inherit eutils

DESCRIPTION="tool for generating C-based recognizers from regular expressions"
HOMEPAGE="http://re2c.sourceforge.net/"
MY_PV="${PV/_/.}"
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_install() {
	dobin re2c
	doman re2c.1
	dodoc README CHANGELOG doc/*
	docinto examples
	dodoc examples/*.c examples/*.re
}
