# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/liboxygenstyle/liboxygenstyle-4.11.2.ebuild,v 1.2 2013/12/08 14:08:13 ago Exp $

EAPI=5

KMNAME="kde-workspace"
KMMODULE="libs/oxygen"
inherit kde4-meta

DESCRIPTION="Library to support the Oxygen style in KDE"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"
