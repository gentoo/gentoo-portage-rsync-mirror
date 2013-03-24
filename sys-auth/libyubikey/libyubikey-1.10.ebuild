# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libyubikey/libyubikey-1.10.ebuild,v 1.1 2013/03/24 14:08:53 flameeyes Exp $

EAPI=5

inherit eutils autotools-utils

DESCRIPTION="Yubico C low-level library"
HOMEPAGE="https://github.com/Yubico/yubico-c"
SRC_URI="http://yubico-c.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"
IUSE="static-libs"

DOCS=( AUTHORS ChangeLog NEWS README THANKS )
