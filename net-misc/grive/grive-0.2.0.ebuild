# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grive/grive-0.2.0.ebuild,v 1.6 2013/01/11 22:36:50 ottxor Exp $

EAPI=4

inherit cmake-utils eutils multilib

if [[ ${PV} = *9999 ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/Grive/${PN}.git"
else
	inherit eutils vcs-snapshot
	SRC_URI="mirror://github/Grive/${PN}/tarball/v${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="an open source Linux client for Google Drive"
HOMEPAGE="http://www.lbreda.com/grive/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/boost
	dev-libs/expat
	dev-libs/json-c
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	net-misc/curl
	sys-devel/binutils
	sys-libs/glibc
	sys-libs/zlib
	"

DEPEND="${RDEPEND}"

DOCS=( "README" )

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-check-bfd.h.patch
}
