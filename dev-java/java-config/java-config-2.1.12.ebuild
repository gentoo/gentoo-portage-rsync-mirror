# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-2.1.12.ebuild,v 1.2 2012/09/16 13:20:41 chithanh Exp $

EAPI="2"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils fdo-mime gnome2-utils

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=dev-java/java-config-wrapper-0.15"
# https://bugs.gentoo.org/show_bug.cgi?id=315229
PDEPEND=">=virtual/jre-1.5"
# Tests fail when java-config isn't already installed.
RESTRICT="test"
RESTRICT_PYTHON_ABIS="2.4 2.5 *-jython"

PYTHON_MODNAME="java_config_2"

src_prepare() {
	distutils_src_prepare

	cp config/jdk-defaults-{x86,amd64}-fbsd.conf || die #415397
	echo "*= icedtea-7 icedtea-6 icedtea-bin-7 icedtea-bin-6" \
		> config/jdk-defaults-arm.conf || die #305773
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" src/run-test-suite.py
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" src/run-test-suite2.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/mimelnk #350459

	insinto /usr/share/java-config-2/config/
	newins config/jdk-defaults-${ARCH}.conf jdk-defaults.conf || die "arch config not found"
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
