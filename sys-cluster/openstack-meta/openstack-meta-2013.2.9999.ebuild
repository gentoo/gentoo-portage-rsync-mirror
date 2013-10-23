# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openstack-meta/openstack-meta-2013.2.9999.ebuild,v 1.1 2013/10/23 06:20:03 prometheanfire Exp $

EAPI=5

DESCRIPTION="A openstack meta-package for installing the various openstack pieces"
HOMEPAGE="https://openstack.org"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="keystone swift neutron glance cinder nova horizon"

DEPEND=""
RDEPEND="keystone? ( ~sys-auth/keystone-2013.2.9999 )
		swift? ( ~sys-cluster/swift-2013.2.9999 )
		neutron? ( ~sys-cluster/neutron-2013.2.9999 )
		glance? ( ~app-admin/glance-2013.2.9999 )
		cinder? ( ~sys-cluster/cinder-2013.2.9999 )
		nova? ( ~sys-cluster/nova-2013.2.9999 )
		horizon? ( ~www-apps/horizon-2013.2.9999 )"
