# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/binwalk/binwalk-0.5.0.ebuild,v 1.1 2013/01/02 22:13:05 radhermit Exp $

EAPI="5"

inherit eutils

DESCRIPTION="A tool for identifying files embedded inside firmware images"
HOMEPAGE="http://code.google.com/p/binwalk/"
SRC_URI="http://binwalk.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/file"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/src"

DOCS=( ../docs/README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch
}

src_configure() {
	econf --disable-updates
}
