# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/packagekit/packagekit-0.8.15.ebuild,v 1.1 2013/12/18 05:28:40 lxnay Exp $

EAPI="5"

DESCRIPTION="PackageKit Package Manager interface (meta package)"
HOMEPAGE="http://www.packagekit.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gtk"

RDEPEND="gtk? ( ~app-admin/packagekit-gtk-${PV} )"
DEPEND="${RDEPEND}"
