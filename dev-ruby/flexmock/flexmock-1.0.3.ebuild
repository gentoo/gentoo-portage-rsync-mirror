# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flexmock/flexmock-1.0.3.ebuild,v 1.2 2013/01/15 07:18:47 zerochaos Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc doc/*.rdoc doc/releases/*"

inherit ruby-fakegem

DESCRIPTION="Simple mock object library for Ruby unit testing"
HOMEPAGE="http://${PN}.rubyforge.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

all_ruby_prepare() {
	# Custom template not found in package
	sed -i -e '/jamis/d' Rakefile || die
}
