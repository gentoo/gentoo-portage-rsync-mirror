# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/postfix-logwatch/postfix-logwatch-1.39.07.ebuild,v 1.1 2013/12/03 13:28:25 mjo Exp $

EAPI=5

DESCRIPTION="A log analyzer for postfix"
HOMEPAGE="http://logreporters.sourceforge.net/"
SRC_URI="mirror://sourceforge/logreporters/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="logwatch"

RDEPEND="dev-lang/perl"

src_compile() {
	# The default make target just outputs instructions. We don't want
	# the user to see these, so we avoid the default emake.
	:
}

src_install() {
	# There are two different "versions" of the package in the
	# tarball: a standalone executable and a logwatch filter. The
	# standalone is always installed. However, the logwatch filter is
	# only installed with USE="logwatch".
	dodoc Bugs Changes README ${PN}.conf-topn
	doman ${PN}.1
	dobin ${PN}
	insinto /etc
	doins ${PN}.conf

	if use logwatch; then
		# Remove the taint mode (-T) switch from the header of the
		# standalone executable, and save the result as our logwatch
		# filter.
		sed 's~^#!/usr/bin/perl -T$~#!/usr/bin/perl~' ${PN} > postfix \
			|| die "failed to remove the perl taint switch"

		insinto /etc/logwatch/scripts/services
		doins postfix

		insinto /etc/logwatch/conf/services
		newins ${PN}.conf postfix.conf
	fi
}
