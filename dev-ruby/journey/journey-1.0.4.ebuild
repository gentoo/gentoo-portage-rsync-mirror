# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/journey/journey-1.0.4.ebuild,v 1.2 2012/09/17 16:41:25 grobian Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit ruby-fakegem versionator

DESCRIPTION="Journey is a router.  It routes requests."
HOMEPAGE="https://github.com/rails/journey"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe )"
ruby_add_bdepend "test? ( dev-ruby/hoe dev-ruby/json dev-ruby/minitest )"
