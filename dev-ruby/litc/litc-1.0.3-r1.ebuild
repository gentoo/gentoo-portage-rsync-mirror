# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/litc/litc-1.0.3-r1.ebuild,v 1.1 2013/11/17 21:22:21 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC="rerdoc"
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A tiny ruby module for Amazon EC2 intance metadata"
HOMEPAGE="http://github.com/bkaney/litc"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_bdepend "test? ( dev-ruby/shoulda dev-ruby/fakeweb )"

all_ruby_prepare() {
	# Don't check dependencies since we provide slightly different packages.
	sed -i -e '/check_dependencies/d' Rakefile || die

	sed -i -e '/ruby-debug/ s:^:#:' test/helper.rb || die
}
