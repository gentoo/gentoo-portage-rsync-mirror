# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-2.2.0.ebuild,v 1.12 2014/11/29 09:56:32 pacho Exp $

EAPI="5"

# jython depends on java-config, so don't add it or things will break
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Java environment configuration query tool"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="http://dev.gentoo.org/~sera/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

# baselayout-java is added as a dep till it can be added to eclass.
RDEPEND="
	>=dev-java/java-config-wrapper-0.15
	sys-apps/baselayout-java
	sys-apps/portage"

python_test() {
	esetup.py test || die
}
