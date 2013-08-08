# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radius/radius-0.7.3.ebuild,v 1.3 2013/08/08 19:30:39 maekke Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG QUICKSTART.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Powerful tag-based template system."
HOMEPAGE="http://radius.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/kramdown )"
