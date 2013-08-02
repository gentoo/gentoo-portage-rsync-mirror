# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-4.10.5.ebuild,v 1.6 2013/08/02 14:29:28 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE free disk space utility"
HOMEPAGE="http://utils.kde.org/projects/kdf"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_unpack() {
	kde4-base_src_unpack
}
