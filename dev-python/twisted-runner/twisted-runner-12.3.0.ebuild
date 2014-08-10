# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-12.3.0.ebuild,v 1.11 2014/08/10 21:24:15 slyfox Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 *-jython"
MY_PACKAGE="Runner"

inherit twisted versionator

DESCRIPTION="Twisted Runner is a process management library and inetd replacement"

KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-core-$(get_version_component_range 1-2)*"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/runner"

src_install() {
	twisted_src_install
	python_clean_installation_image
}
