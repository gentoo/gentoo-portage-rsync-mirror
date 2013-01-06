# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-11.0.0.ebuild,v 1.11 2012/10/05 14:46:45 marienz Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"
MY_PACKAGE="Words"

inherit twisted versionator

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	=dev-python/twisted-web-$(get_version_component_range 1-2)*"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/plugins twisted/words"

src_prepare() {
	distutils_src_prepare

	# Delete documentation for no longer available "im" script.
	rm -fr doc/man
}
