# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/zeroconf-ioslave/zeroconf-ioslave-4.12.4.ebuild,v 1.1 2014/04/01 18:09:12 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="!kde-base/kdnssd:4"
