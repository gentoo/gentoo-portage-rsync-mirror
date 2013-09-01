# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-12.3.0.ebuild,v 1.6 2013/09/01 18:38:23 ago Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 *-jython"
MY_PACKAGE="Words"

inherit twisted versionator

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-core-$(get_version_component_range 1-2)*
	=dev-python/twisted-web-$(get_version_component_range 1-2)*"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/plugins twisted/words"
