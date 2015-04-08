# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/polysh/polysh-0.4-r1.ebuild,v 1.5 2014/06/05 11:28:17 grobian Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Aggregate several remote shells into one"
HOMEPAGE="http://guichaz.free.fr/polysh/"
SRC_URI="http://guichaz.free.fr/polysh/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""
