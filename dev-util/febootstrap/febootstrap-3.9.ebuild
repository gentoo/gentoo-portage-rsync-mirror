# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/febootstrap/febootstrap-3.9.ebuild,v 1.1 2011/12/10 20:02:54 maksbotan Exp $

EAPI="4"

AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="Bootstrapping tool for creating supermin appliances"
HOMEPAGE="http://people.redhat.com/~rjones/febootstrap/"
SRC_URI="http://people.redhat.com/~rjones/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/ocaml[ocamlopt]
	dev-ml/findlib
	dev-lang/perl
	sys-fs/e2fsprogs
	sys-libs/e2fsprogs-libs
	=app-arch/rpm-4*
	>=sys-apps/yum-3.2.21"

DEPEND="${RDEPEND}"
