# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcminit/kcminit-4.10.0.ebuild,v 1.1 2013/02/07 04:57:38 alexxy Exp $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep ksplash)
"
RDEPEND="${DEPEND}"
