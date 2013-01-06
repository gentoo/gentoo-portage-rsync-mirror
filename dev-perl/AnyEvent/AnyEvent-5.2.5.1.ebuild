# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent/AnyEvent-5.2.5.1.ebuild,v 1.6 2011/09/11 17:58:24 armin76 Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=MLEHMANN
MY_P=${PN}-$(get_major_version).$(delete_all_version_separators $(get_after_major_version))
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="provide framework for multiple event loops"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 sparc x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Event"
DEPEND=""

SRC_TEST="do"
