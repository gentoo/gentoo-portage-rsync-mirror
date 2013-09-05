# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rackspace-auth-openstack/rackspace-auth-openstack-9999.ebuild,v 1.2 2013/09/05 18:46:46 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/emonty/${PN}.git
	https://github.com/emonty/${PN}.git"

DESCRIPTION="Rackspace Auth Plugin for OpenStack Clients"
HOMEPAGE="https://github.com/emonty/rackspace-auth-openstack"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
