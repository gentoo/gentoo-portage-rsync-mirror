# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/packetfu/packetfu-1.1.10.ebuild,v 1.1 2014/01/15 07:39:09 graaff Exp $

EAPI=5

# ruby20 fails tests
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit multilib ruby-fakegem

DESCRIPTION="A mid-level packet manipulation library"
HOMEPAGE="https://rubygems.org/gems/packetfu"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend " >=dev-ruby/pcaprub-0.9.2"

all_ruby_prepare() {
	# Broken for version numbers with multiple digits...
	sed -i -e '/reports a version number/,/end/ s:^:#:' spec/packetfu_spec.rb || die
}
