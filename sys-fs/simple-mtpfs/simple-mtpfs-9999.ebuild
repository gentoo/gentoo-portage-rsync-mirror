# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/simple-mtpfs/simple-mtpfs-9999.ebuild,v 1.1 2013/04/06 07:28:50 scarabeus Exp $

EAPI=5

EGIT_REPO_URI="git://github.com/phatina/${PN}.git"
inherit autotools-utils eutils git-2

DESCRIPTION="Simple MTP fuse filesystem driver"
HOMEPAGE="https://github.com/phatina/simple-mtpfs"
[[ ${PV} == 9999 ]] || SRC_URI="mirror://github/phatina/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/libmtp
	>=sys-fs/fuse-2.8
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

AUTOTOOLS_AUTORECONF=1
