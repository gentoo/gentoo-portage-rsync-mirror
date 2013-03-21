# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/simple-mtpfs/simple-mtpfs-0.1.ebuild,v 1.1 2013/03/20 23:32:20 sochotnicky Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Simple MTP fuse filesystem driver"
HOMEPAGE="https://github.com/phatina/simple-mtpfs"
SRC_URI="mirror://github/phatina/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libmtp
		>=sys-fs/fuse-2.8"
RDEPEND="${DEPEND}"

src_prepare()
{
	default
	# run autoreconf since we are running from git tag
	eautoreconf
}

src_compile()
{
	# make sure we use verbose make
	emake V=1
}

src_install()
{
	default
	doman man/${PN}.1
}
