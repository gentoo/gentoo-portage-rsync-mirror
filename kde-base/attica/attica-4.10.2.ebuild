# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/attica/attica-4.10.2.ebuild,v 1.5 2013/05/05 10:14:33 ago Exp $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Open Collaboration Services provider management"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=dev-libs/libattica-0.1.4
"
RDEPEND="${DEPEND}"
