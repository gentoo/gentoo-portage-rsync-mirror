# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nipper/nipper-0.11.8.ebuild,v 1.1 2008/06/08 14:25:37 ikelos Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Script to parse and report on Cisco config errors"
HOMEPAGE="http://www.sourceforge.net/projects/nipper"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P/_/-}

src_install() {
	dobin ${PN}
	insinto /etc
	doins ${PN}.conf
	doman man/*
	dodoc Readme INSTALL TODO Changelog docs/*
}
