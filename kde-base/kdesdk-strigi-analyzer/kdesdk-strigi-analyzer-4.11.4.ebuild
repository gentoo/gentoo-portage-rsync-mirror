# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-strigi-analyzer/kdesdk-strigi-analyzer-4.11.4.ebuild,v 1.1 2014/01/07 16:23:58 scarabeus Exp $

EAPI=5

KMNAME="kdesdk-strigi-analyzers"
inherit kde4-base

DESCRIPTION="kdesdk: strigi plugins"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${KMNAME}-${PV}"
