# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-ssh-gateway/net-ssh-gateway-1.1.0-r1.ebuild,v 1.7 2014/04/05 23:09:41 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A simple library to assist in enabling tunneled Net::SSH connections"
HOMEPAGE="http://net-ssh.rubyforge.org/gateway"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "dev-ruby/test-unit:2"

ruby_add_rdepend ">=dev-ruby/net-ssh-2.0.0"

each_ruby_test() {
	RUBYLIB=lib ruby-ng_testrb-2 test/*
}
