# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/stompserver/stompserver-0.9.9-r2.ebuild,v 1.1 2013/08/22 00:13:43 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"
RUBY_FAKEGEM_EXTRAINSTALL="client config"

inherit ruby-fakegem

DESCRIPTION="Stomp messaging server with FIFO queues, queue monitoring, and basic authentication."
HOMEPAGE="http://stompserver.rubyforge.org"

LICENSE="GPL-2 Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe )"
ruby_add_bdepend "test? ( dev-ruby/hoe )"

ruby_add_rdepend "dev-ruby/daemons
	dev-ruby/eventmachine"

each_ruby_prepare() {
	case ${RUBY} in
		*ruby19)
			epatch "${FILESDIR}"/${P}-ruby19.patch
			;;
		*)
			;;
	esac
}

all_ruby_install() {
	all_fakegem_install

	doinitd "${FILESDIR}"/stompserver
}
